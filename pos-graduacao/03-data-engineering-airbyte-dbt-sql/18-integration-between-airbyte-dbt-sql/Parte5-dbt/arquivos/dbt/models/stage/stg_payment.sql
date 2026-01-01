select * 
from 
    {{ source('dsa_schema', 'payment') }}
