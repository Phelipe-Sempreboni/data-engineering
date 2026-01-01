select * 
from 
    {{ source('dsa_schema', 'inventory') }}
