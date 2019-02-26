using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Pizzatorium_App.Models;

namespace Pizzatorium_App.Controllers
{
    public class OrdersController : Controller
    {
        private PizzaDBEntities1 db = new PizzaDBEntities1();

        // GET: Orders
        public ActionResult Index()
        {
            foreach (Customer cust in db.Customers)
            {
                cust.IsLogged = false;
            }

            return View();
        }

        public ActionResult Login()
        {

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Login(Customer customer)
        {
            try
            {
                var _customer = (from c in db.Customers
                                 where c.Username == customer.Username && c.Password == customer.Password
                                 select c).First() as Customer;

                if (_customer != null)
                {
                    _customer.IsLogged = true;
                    db.SaveChanges();
                    Order ord = new Order();
                    ord.CustomerId = _customer.Id;
                    ord.Price = 0;


                    return RedirectToAction("Design", ord);
                }
            }
            catch (Exception)
            {

                ViewBag.Error = "Login Name or Password do not match try again";
            }
            return View();
        }

        public ActionResult Register()
        {
            ViewBag.AreaId = new SelectList(db.Areas, "Id", "Name");
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Register(Customer customer)
        {
            try
            {
                customer.IsLogged = false;
                if (ModelState.IsValid)
                {
                    using (var db = new PizzaDBEntities1())
                    {
                        db.Customers.Add(customer);
                        db.SaveChanges();
                        return RedirectToAction("Login");
                    }
                }

                return View(customer);
            }
            catch (Exception)
            {
                ViewBag.Error = "Please Check that all fields are correct";
                return View(customer);
            }
            
        }

        [HttpGet]
        public ActionResult Design(Order order)
        {
            try
            {
                order.Customer = db.Customers.Where(cus => cus.Id == order.CustomerId).First();

                if (order.Customer.IsLogged == true)
                {
                    ViewBag.Size = db.Sizes.ToList();

                    ViewBag.Ingredients = db.Ingredients.ToList();
                    return View(order);
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }
            

            
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Design(Order order, FormCollection form)
        {
            Pizza myPizza = new Pizza();

            var checkedSize = form["CheckedSize"].ToString();
            Size pizzaSize = new Size();

            using (var db = new PizzaDBEntities1())
            {
                pizzaSize = db.Sizes.Where(s => s.SizeName == checkedSize).First();
                myPizza.SizeId = pizzaSize.Id;
                order.Price += pizzaSize.SizePrice;
            }

            var selectedIng = form["IngredientSelection"].ToString();
            List<string> ingList = selectedIng.ToString().Split(',').ToList();

            myPizza.Ingredients = selectedIng;

            foreach (string i in ingList)
            {
                var ingr = db.Ingredients.Where(ingd => ingd.IngredientName == i).First();


                order.Price += ingr.IngredientPrice;
            }

            db.Orders.Add(order);
            db.SaveChanges();

            myPizza.OrderId = order.Id;
            db.Pizzas.Add(myPizza);
            db.SaveChanges();

            return RedirectToAction("Final", myPizza);
        }

        public ActionResult Final(Pizza myPizza)
        {

            try
            {
                myPizza.Order = db.Orders.Where(Oid => Oid.Id == myPizza.OrderId).First();

                myPizza.Order.Customer = db.Customers.Where(cus => cus.Id == myPizza.Order.CustomerId).First();

                if (myPizza.Order.Customer.IsLogged == true)
                {
                    ViewBag.Ingredients = myPizza.Ingredients.ToString().Split(',').ToList();

                    myPizza.Size = db.Sizes.Where(S => S.Id == myPizza.SizeId).First();
                    return View(myPizza);
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }

        }

        [HttpPost]
        public ActionResult Final(Pizza myPizza, FormCollection form)
        {

            myPizza.Order = db.Orders.Where(Oid => Oid.Id == myPizza.OrderId).First();

            var payments = form["payments"].ToString();
            List<string> PaymentList = payments.ToString().Split(',').ToList();

            foreach (string payment in PaymentList)
            {
                var pay = from p in db.PaymentTypes
                          where p.Name == payment
                          select p;

                foreach (PaymentType item in pay)
                {
                    myPizza.Order.PaymentTypeId = item.Id;
                }

            }
            db.Entry(myPizza.Order).State = EntityState.Modified;
            db.SaveChanges();

            ViewBag.PaymentTypeId = new SelectList(db.PaymentTypes, "Id", "Name", myPizza.Order.PaymentTypeId);

            return RedirectToAction("ThankYou", myPizza);
        }

        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            Pizza pizza = db.Pizzas.Find(id);

            if (pizza == null)
            {
                return HttpNotFound();
            }

            try
            {
                pizza.Order = db.Orders.Where(Oid => Oid.Id == pizza.OrderId).First();

                pizza.Order.Customer = db.Customers.Where(cus => cus.Id == pizza.Order.CustomerId).First();

                if (pizza.Order.Customer.IsLogged == true)
                {
                    pizza.Ingredients = "";

                    db.SaveChanges();

                    db.SaveChanges();

                    ViewBag.OrderId = new SelectList(db.Orders, "Id", "Id", pizza.OrderId);
                    ViewBag.Ingredients = db.Ingredients.ToList();
                    ViewBag.Size = db.Sizes.ToList();
                    return View(pizza);
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }


        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "Id,SizeId,OrderId")] Pizza pizza, FormCollection form)
        {
            if (ModelState.IsValid)
            {
                pizza.OrderId = pizza.Id;
                pizza.Order = db.Orders.Where(Oid => Oid.Id == pizza.OrderId).First();
                pizza.Order.Price = 0;

                var selectedIng = form["IngredientSelection"].ToString();
                List<string> ingList = selectedIng.ToString().Split(',').ToList();

                pizza.Ingredients = selectedIng;

                foreach (string i in ingList)
                {
                    var ingr = db.Ingredients.Where(ingd => ingd.IngredientName == i).First();

                    pizza.Order.Price += ingr.IngredientPrice;
                }

                var checkedSize = form["CheckedSize"].ToString();

                Size pizzaSize = new Size();

                using (var db = new PizzaDBEntities1())
                {
                    pizzaSize = db.Sizes.Where(s => s.SizeName == checkedSize).First();
                    pizza.SizeId = pizzaSize.Id;
                    pizza.Order.Price += pizzaSize.SizePrice;
                }

                db.SaveChanges();
                return RedirectToAction("Final", pizza);
            }
            ViewBag.OrderId = new SelectList(db.Orders, "Id", "Id", pizza.OrderId);
            ViewBag.SizeId = new SelectList(db.Sizes, "Id", "SizeName", pizza.SizeId);
            return View(pizza);
        }

        public ActionResult ThankYou(Pizza myPizza)
        {

            try
            {
                myPizza.Order = db.Orders.Where(Oid => Oid.Id == myPizza.OrderId).First();

                myPizza.Order.Customer = db.Customers.Where(cus => cus.Id == myPizza.Order.CustomerId).First();

                if (myPizza.Order.Customer.IsLogged == true)
                {
                    myPizza.Order = db.Orders.Where(Oid => Oid.Id == myPizza.OrderId).First();
                    myPizza.Size = db.Sizes.Where(S => S.Id == myPizza.SizeId).First();

                    string a = myPizza.Order.Customer.Area.DeliveryGuy.Image;
                    return View(myPizza);
                }
                else
                {
                    return RedirectToAction("Index");
                }
            }
            catch (Exception)
            {

                return RedirectToAction("Index");
            }

        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
