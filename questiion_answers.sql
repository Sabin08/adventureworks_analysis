-- TABLE
CREATE TABLE countryregioncurrency (
    countryregioncode TEXT,
    currencycode TEXT,
    modifieddate DATE
    );
CREATE TABLE currencyrate (
    currencyrateid INTEGER,
    currencyratedate DATE,
    fromcurrencycode TEXT,
    tocurrencycode TEXT,
    averagerate FLOAT,
    endofdayrate FLOAT,
    modifieddate DATE
    );
CREATE TABLE demo (ID integer primary key, Name varchar(20), Hint text );
CREATE TABLE product (
    productid INTEGER,
    NAME TEXT,
    productnumber TEXT,
    makeflag BOOLEAN,
    finishedgoodsflag BOOLEAN,
    color TEXT,
    safetystocklevel INTEGER,
    reorderpoint INTEGER,
    standardcost FLOAT,
    listprice FLOAT,
    size TEXT,
    sizeunitmeasurecode TEXT,
    weightunitmeasurecode TEXT,
    weight FLOAT,
    daystomanufacture INTEGER,
    productline TEXT,
    class TEXT,
    style TEXT,
    productsubcategoryid INTEGER,
    productmodelid INTEGER,
    sellstartdate DATE,
    sellenddate DATE,
    discontinueddate DATE,
    rowguid TEXT,
    modifieddate DATE
    );
CREATE TABLE productcategory (
    productcategoryid INTEGER,
    name TEXT,
    rowguid TEXT,
    modifieddate DATE
    );
CREATE TABLE productdescription (
    productdescriptionid INTEGER,
    description TEXT,
    rowguid TEXT,
    modifieddate DATE
    );
CREATE TABLE productmodelproductdescriptionculture (
    productmodelid INTEGER,
    productdescriptionid INTEGER,
    cultureid TEXT,
    modifieddate DATE
    );
CREATE TABLE productreview (
    productreviewid INTEGER,
    productid INTEGER,
    reviewername TEXT,
    reviewdate DATE,
    emailaddress TEXT,
    rating INTEGER,
    comments TEXT,
    modifeddate DATE
    , modifieddate VARCHAR(19));
CREATE TABLE productsubcategory (
    productsubcategoryid INTEGER,
    productcategoryid INTEGER,
    name TEXT,
    rowguid TEXT,
    modifieddate DATE
    );
CREATE TABLE salesorderdetail (
    salesorderid INTEGER,
    salesorderdetailid INTEGER,
    carriertrackingnumber TEXT,
    orderqty INTEGER,
    productid INTEGER,
    specialofferid INTEGER,
    unitprice FLOAT,
    unitpricediscount FLOAT,
    rowguid TEXT,
    modifieddate DATE
    );
CREATE TABLE salesorderheader (
    salesorderid INTEGER,
    revisionnumber INTEGER,
    orderdate DATE,
    duedate DATE,
    shipdate DATE,
    STATUS TEXT,
    onlineorderflag BOOLEAN,
    purchaseordernumber TEXT,
    accountnumber TEXT,
    customerid INTEGER,
    salespersonid INTEGER,
    territoryid INTEGER,
    billtoaddressid INTEGER,
    shiptoaddressid INTEGER,
    shipmethodid INTEGER,
    creditcardid INTEGER,
    creditcardapprovalcode TEXT,
    currencyrateid INTEGER,
    subtotal FLOAT,
    taxamt FLOAT,
    freight FLOAT,
    totaldue FLOAT,
    comment TEXT,
    rowguid TEXT,
    modifieddate DATE
    );
CREATE TABLE salesperson (
 businessentityid INTEGER,
 territoryid INTEGER,
 salesquota INTEGER,
 bonus INTEGER,
 commissionpct FLOAT,
 salesytd FLOAT,
 saleslastyear FLOAT,
 rowguid TEXT,
 modifieddate DATE
 );
CREATE TABLE salesterritory (
    territoryid INTEGER,
    name TEXT,
    countryregioncode TEXT,
    "group" TEXT,
    salesytd FLOAT,
    saleslastyear FLOAT,
    costytd FLOAT,
    costlastyear FLOAT,
    rowguid TEXT,
    modifieddate DATE
    );
 
-- INDEX
 
-- TRIGGER
 
-- VIEW
 
