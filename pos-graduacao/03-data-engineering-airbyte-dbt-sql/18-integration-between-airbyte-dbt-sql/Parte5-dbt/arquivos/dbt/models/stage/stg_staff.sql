select * 
from 
    {{ source('dsa_schema', 'staff') }}
