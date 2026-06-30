select
    id,
    order_id,
    payment_method,
    amount
from {{ source('stripe', 'payments') }}