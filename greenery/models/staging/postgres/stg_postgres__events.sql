select *
from {{source("postgres", "events")}}