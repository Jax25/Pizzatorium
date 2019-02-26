
-- --------------------------------------------------
-- Entity Designer DDL Script for SQL Server 2005, 2008, 2012 and Azure
-- --------------------------------------------------
-- Date Created: 09/09/2018 18:33:09
-- Generated from EDMX file: F:\Try54\ASP Latest V0.5\New folder\Pizzatorium_App\Pizzatorium_App\Models\PizzaModel.edmx
-- --------------------------------------------------

SET QUOTED_IDENTIFIER OFF;
GO
USE [ThePizzatoriumDB2];
GO
IF SCHEMA_ID(N'dbo') IS NULL EXECUTE(N'CREATE SCHEMA [dbo]');
GO

-- --------------------------------------------------
-- Dropping existing FOREIGN KEY constraints
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[FK__Area__Id__5070F446]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Areas] DROP CONSTRAINT [FK__Area__Id__5070F446];
GO
IF OBJECT_ID(N'[dbo].[FK_Customer_Area]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Customers] DROP CONSTRAINT [FK_Customer_Area];
GO
IF OBJECT_ID(N'[dbo].[FK__Order__CustomerI__32E0915F]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK__Order__CustomerI__32E0915F];
GO
IF OBJECT_ID(N'[dbo].[FK__Order__PaymentTy__33D4B598]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Orders] DROP CONSTRAINT [FK__Order__PaymentTy__33D4B598];
GO
IF OBJECT_ID(N'[dbo].[FK__Pizza__OrderId__59063A47]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Pizzas] DROP CONSTRAINT [FK__Pizza__OrderId__59063A47];
GO
IF OBJECT_ID(N'[dbo].[FK__Pizza__SizeId__5812160E]', 'F') IS NOT NULL
    ALTER TABLE [dbo].[Pizzas] DROP CONSTRAINT [FK__Pizza__SizeId__5812160E];
GO

-- --------------------------------------------------
-- Dropping existing tables
-- --------------------------------------------------

IF OBJECT_ID(N'[dbo].[Areas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Areas];
GO
IF OBJECT_ID(N'[dbo].[Customers]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Customers];
GO
IF OBJECT_ID(N'[dbo].[DeliveryGuys]', 'U') IS NOT NULL
    DROP TABLE [dbo].[DeliveryGuys];
GO
IF OBJECT_ID(N'[dbo].[Ingredients]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Ingredients];
GO
IF OBJECT_ID(N'[dbo].[Orders]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Orders];
GO
IF OBJECT_ID(N'[dbo].[PaymentTypes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[PaymentTypes];
GO
IF OBJECT_ID(N'[dbo].[Pizzas]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Pizzas];
GO
IF OBJECT_ID(N'[dbo].[Sizes]', 'U') IS NOT NULL
    DROP TABLE [dbo].[Sizes];
GO

-- --------------------------------------------------
-- Creating all tables
-- --------------------------------------------------

-- Creating table 'Areas'
CREATE TABLE [dbo].[Areas] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(100)  NOT NULL
);
GO

-- Creating table 'Customers'
CREATE TABLE [dbo].[Customers] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(100)  NOT NULL,
    [Username] varchar(100)  NOT NULL,
    [Password] nvarchar(100)  NOT NULL,
    [FavoritePizza] varchar(100)  NULL,
    [Address] varchar(200)  NOT NULL,
    [AreaId] int  NULL,
    [PhoneNumber] nvarchar(max)  NOT NULL,
    [IsLogged] bit  NOT NULL
);
GO

-- Creating table 'DeliveryGuys'
CREATE TABLE [dbo].[DeliveryGuys] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(100)  NOT NULL,
    [Image] varchar(200)  NOT NULL
);
GO

-- Creating table 'Ingredients'
CREATE TABLE [dbo].[Ingredients] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [IngredientName] varchar(100)  NOT NULL,
    [IngredientPrice] decimal(19,4)  NOT NULL
);
GO

-- Creating table 'Orders'
CREATE TABLE [dbo].[Orders] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [CustomerId] int  NOT NULL,
    [Price] decimal(19,4)  NOT NULL,
    [PaymentTypeId] int  NULL
);
GO

-- Creating table 'PaymentTypes'
CREATE TABLE [dbo].[PaymentTypes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [Name] varchar(100)  NOT NULL
);
GO

-- Creating table 'Pizzas'
CREATE TABLE [dbo].[Pizzas] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [SizeId] int  NOT NULL,
    [OrderId] int  NOT NULL,
    [Ingredients] nvarchar(max)  NOT NULL
);
GO

-- Creating table 'Sizes'
CREATE TABLE [dbo].[Sizes] (
    [Id] int IDENTITY(1,1) NOT NULL,
    [SizeName] varchar(100)  NOT NULL,
    [SizePrice] decimal(19,4)  NOT NULL
);
GO

-- --------------------------------------------------
-- Creating all PRIMARY KEY constraints
-- --------------------------------------------------

-- Creating primary key on [Id] in table 'Areas'
ALTER TABLE [dbo].[Areas]
ADD CONSTRAINT [PK_Areas]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [PK_Customers]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'DeliveryGuys'
ALTER TABLE [dbo].[DeliveryGuys]
ADD CONSTRAINT [PK_DeliveryGuys]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Ingredients'
ALTER TABLE [dbo].[Ingredients]
ADD CONSTRAINT [PK_Ingredients]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [PK_Orders]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'PaymentTypes'
ALTER TABLE [dbo].[PaymentTypes]
ADD CONSTRAINT [PK_PaymentTypes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Pizzas'
ALTER TABLE [dbo].[Pizzas]
ADD CONSTRAINT [PK_Pizzas]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- Creating primary key on [Id] in table 'Sizes'
ALTER TABLE [dbo].[Sizes]
ADD CONSTRAINT [PK_Sizes]
    PRIMARY KEY CLUSTERED ([Id] ASC);
GO

-- --------------------------------------------------
-- Creating all FOREIGN KEY constraints
-- --------------------------------------------------

-- Creating foreign key on [Id] in table 'Areas'
ALTER TABLE [dbo].[Areas]
ADD CONSTRAINT [FK__Area__Id__5070F446]
    FOREIGN KEY ([Id])
    REFERENCES [dbo].[DeliveryGuys]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating foreign key on [AreaId] in table 'Customers'
ALTER TABLE [dbo].[Customers]
ADD CONSTRAINT [FK_Customer_Area]
    FOREIGN KEY ([AreaId])
    REFERENCES [dbo].[Areas]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK_Customer_Area'
CREATE INDEX [IX_FK_Customer_Area]
ON [dbo].[Customers]
    ([AreaId]);
GO

-- Creating foreign key on [CustomerId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK__Order__CustomerI__32E0915F]
    FOREIGN KEY ([CustomerId])
    REFERENCES [dbo].[Customers]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Order__CustomerI__32E0915F'
CREATE INDEX [IX_FK__Order__CustomerI__32E0915F]
ON [dbo].[Orders]
    ([CustomerId]);
GO

-- Creating foreign key on [PaymentTypeId] in table 'Orders'
ALTER TABLE [dbo].[Orders]
ADD CONSTRAINT [FK__Order__PaymentTy__33D4B598]
    FOREIGN KEY ([PaymentTypeId])
    REFERENCES [dbo].[PaymentTypes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Order__PaymentTy__33D4B598'
CREATE INDEX [IX_FK__Order__PaymentTy__33D4B598]
ON [dbo].[Orders]
    ([PaymentTypeId]);
GO

-- Creating foreign key on [OrderId] in table 'Pizzas'
ALTER TABLE [dbo].[Pizzas]
ADD CONSTRAINT [FK__Pizza__OrderId__59063A47]
    FOREIGN KEY ([OrderId])
    REFERENCES [dbo].[Orders]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Pizza__OrderId__59063A47'
CREATE INDEX [IX_FK__Pizza__OrderId__59063A47]
ON [dbo].[Pizzas]
    ([OrderId]);
GO

-- Creating foreign key on [SizeId] in table 'Pizzas'
ALTER TABLE [dbo].[Pizzas]
ADD CONSTRAINT [FK__Pizza__SizeId__5812160E]
    FOREIGN KEY ([SizeId])
    REFERENCES [dbo].[Sizes]
        ([Id])
    ON DELETE NO ACTION ON UPDATE NO ACTION;
GO

-- Creating non-clustered index for FOREIGN KEY 'FK__Pizza__SizeId__5812160E'
CREATE INDEX [IX_FK__Pizza__SizeId__5812160E]
ON [dbo].[Pizzas]
    ([SizeId]);
GO

-- --------------------------------------------------
-- Script has ended
-- --------------------------------------------------