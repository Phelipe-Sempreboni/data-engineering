select * 
from 
    {{ source('dsa_schema', 'country') }}
