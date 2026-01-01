select * 
from 
    {{ source('dsa_schema', 'city') }}
