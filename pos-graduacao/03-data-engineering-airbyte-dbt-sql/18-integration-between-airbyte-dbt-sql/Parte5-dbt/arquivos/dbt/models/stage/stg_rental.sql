select * 
from 
    {{ source('dsa_schema', 'rental') }}
