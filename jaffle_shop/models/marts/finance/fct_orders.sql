with orders as
(
    select * from {{ ref('stg_orders') }}
),
payments as
(
    select * from {{ ref('stg_payments') }}
),
order_payments as
(
    select 
    p.order_id,
    sum(p.amount) as amount
    from payments p
    left join orders o on p.order_id = o.order_id
    where o.status = 'completed'
    group by p.order_id
)
select 
    o.order_id,
    o.customer_id,
    o.order_date,
    coalesce (p.amount, 0) as amount
from {{ ref('stg_orders') }} o
left join order_payments p using (order_id)