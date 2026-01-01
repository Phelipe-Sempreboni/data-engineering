select * 
from 
    {{ source('dsa_schema', 'customer') }}
