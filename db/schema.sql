-- readings.
CREATE TABLE IF NOT EXISTS readings(
    rid serial,
    ssid varchar(256),
    provider varchar(512),
    record_start timestamp,
    record_end timestamp,
    record_duration int,
    speed_download numeric,
    speed_upload numeric
);