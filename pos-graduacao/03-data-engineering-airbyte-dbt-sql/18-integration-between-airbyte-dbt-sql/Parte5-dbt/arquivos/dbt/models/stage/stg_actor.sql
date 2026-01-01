select * 
from 
    {{ source('dsa_schema', 'actor') }}
