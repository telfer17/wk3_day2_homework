DROP TABLE IF EXISTS property_search;

CREATE TABLE property_search(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT4,
  bedrooms INT2,
  year_built INT2,
  status VARCHAR(255),
  size INT2,
  build VARCHAR(255)
);
