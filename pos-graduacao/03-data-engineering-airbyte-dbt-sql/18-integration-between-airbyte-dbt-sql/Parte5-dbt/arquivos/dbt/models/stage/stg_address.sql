select * 
from 
    {{ source('dsa_schema', 'address') }}
