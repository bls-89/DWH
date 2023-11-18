CREATE TABLE IF NOT EXISTS public.plan (
    product_id int not NULL,
    shop_name varchar not NULL,
    plan_count int not NULL,
    plan_date date not NULL
);

CREATE TABLE IF NOT EXISTS public.products (
    product_id int not NULL,
    product_name varchar not NULL,
    price int not NULL,
    PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS public.shop_dns(
    date date not NULL,
    product_id int not NULL,
    sales_count int not NULL
);

CREATE TABLE IF NOT EXISTS public.shop_mvideo(
    date date not NULL,
    product_id int not NULL,
    sales_count int not NULL
);

CREATE TABLE IF NOT EXISTS public.shop_sitilink(
    date date not NULL,
    product_id int not NULL,
    sales_count int not NULL
);

--словарь для витрины с мамагазинами и их product_id (идиотская затея на фоне того, что входные таблтцы трогать нельзя, странно как принимаю домашку с измененными?????)



--CREATE TABLE IF NOT EXISTS public.shops (
    --shop_id int not NULL,
   -- product_name varchar not NULL,
   -- price int not NULL,
   -- PRIMARY KEY (product_id)
--);

INSERT INTO public.plan (product_id, shop_name, plan_count, plan_date) VALUES
    (1,'dns', 11, '2023-11-30'),
    (2,'dns', 21, '2023-11-30'),
    (3,'dns', 31, '2023-11-30'),
    (1,'mvideo', 12, '2023-11-30'),
    (2,'mvideo', 22, '2023-11-30'),
    (3,'mvideo', 32, '2023-11-30'),
    (1,'sitilink', 13, '2023-11-30'),
    (2,'sitilink', 23, '2023-11-30'),
    (3,'sitilink', 33, '2023-11-30'),
    (1,'dns', 110, '2023-10-30'),
    (2,'dns', 210, '2023-10-30'),
    (3,'dns', 310, '2023-10-30'),
    (1,'mvideo', 120, '2023-10-30'),
    (2,'mvideo', 220, '2023-10-30'),
    (3,'mvideo', 320, '2023-10-30'),
    (1,'sitilink', 130, '2023-10-30'),
    (2,'sitilink', 230, '2023-10-30'),
    (3,'sitilink', 330, '2023-10-30');



INSERT INTO public.products (product_id, product_name, price) VALUES 
(1,'Испорченный телефон',100),
(2,'Сарафанное радио',200),
(3,'Патефон',300);


INSERT INTO public.shop_dns (date, product_id, sales_count) VALUES
('2023-11-01',1,1),
('2023-11-01',2,1),
('2023-11-01',3,1),
('2023-11-02',1,1),
('2023-11-02',2,1),
('2023-11-02',3,1),
('2023-11-03',1,1),
('2023-11-03',2,1),
('2023-11-03',3,1),
('2023-10-01',1,10),
('2023-10-01',2,10),
('2023-10-01',3,10),
('2023-10-02',1,10),
('2023-10-02',2,10),
('2023-10-02',3,10),
('2023-10-03',1,10),
('2023-10-03',2,10),
('2023-10-03',3,10);


INSERT INTO public.shop_mvideo (date, product_id, sales_count) VALUES
('2023-11-01',1,2),
('2023-11-01',2,2),
('2023-11-01',3,2),
('2023-11-02',1,2),
('2023-11-02',2,2),
('2023-11-02',3,2),
('2023-11-03',1,2),
('2023-11-03',2,2),
('2023-11-03',3,2),
('2023-10-01',1,10),
('2023-10-01',2,10),
('2023-10-01',3,10),
('2023-10-02',1,10),
('2023-10-02',2,10),
('2023-10-02',3,10),
('2023-10-03',1,10),
('2023-10-03',2,10),
('2023-10-03',3,10);

INSERT INTO public.shop_sitilink (date, product_id, sales_count) VALUES
('2023-11-01',1,3),
('2023-11-01',2,3),
('2023-11-01',3,3),
('2023-11-02',1,3),
('2023-11-02',2,3),
('2023-11-02',3,3),
('2023-11-03',1,3),
('2023-11-03',2,3),
('2023-11-03',3,3),
('2023-10-01',1,10),
('2023-10-01',2,10),
('2023-10-01',3,10),
('2023-10-02',1,10),
('2023-10-02',2,10),
('2023-10-02',3,10),
('2023-10-03',1,10),
('2023-10-03',2,10),
('2023-10-03',3,10);

WITH sales AS
(SELECT TO_CHAR("date", 'YYYY-MM') AS sale_month, shops.product_id, SUM(shops.sales_count) AS sales_fact, SUM(sales_count * products.price)AS income_fact , shop_name
FROM (SELECT *, 'dns' as shop_name FROM shop_dns  
UNION ALL
SELECT *, 'mvideo' as shop_name FROM shop_mvideo  
UNION ALL
SELECT *, 'sitilink' as shop_name FROM shop_sitilink
) as shops INNER JOIN
products ON shops.product_id = products.product_id
GROUP BY sale_month, shops.product_id, shop_name,sales_count,products.price
ORDER BY sale_month, shop_name,product_id),
stats AS 
(SELECT TO_CHAR("plan_date", 'YYYY-MM') AS sale_month,shop_name,plan.product_id, plan_count AS sales_plan, (plan_count * products.price) as income_plan
FROM plan INNER JOIN products ON plan.product_id = products.product_id)
SELECT stats.sale_month,sales.shop_name,sales.product_id,sales_fact,sales_plan,(sales_fact / sales_plan::float)*100|| '%'  as "sF/sP",sales.income_fact, stats.income_plan, (income_fact / income_plan::float)*100 || '%' as "iF/iP"
FROM stats INNER JOIN sales ON stats.sale_month = sales.sale_month AND stats.shop_name=sales.shop_name AND stats.product_id = sales.product_id 
GROUP BY stats.sale_month, sales.shop_name,sales.sales_fact,sales.product_id,stats.sales_plan,sales.income_fact,stats.income_plan
ORDER BY sale_month, shop_name,product_id