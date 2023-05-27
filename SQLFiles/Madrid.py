import requests

response = requests.get(f"https://archive-api.open-meteo.com/v1/archive?latitude=40.42&longitude=-3.70&start_date=2001-08-01&end_date=2017-08-31&daily=temperature_2m_max,shortwave_radiation_sum&timezone=Europe%2FLondon")
print(response.json())