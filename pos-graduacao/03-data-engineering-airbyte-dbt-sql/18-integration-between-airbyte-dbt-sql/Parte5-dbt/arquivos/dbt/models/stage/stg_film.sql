select * 
from 
    {{ source('dsa_schema', 'film') }}
