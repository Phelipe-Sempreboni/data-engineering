select * 
from 
    {{ source('dsa_schema', 'store') }}
