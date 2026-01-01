select * 
from 
    {{ source('dsa_schema', 'category') }}
