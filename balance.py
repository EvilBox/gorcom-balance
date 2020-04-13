import requests
import pickle

url = "http://stat.gorcom.ru"
headers = {"User-Agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_5_3) AppleWebKit/853.1.15 (KHTML, like Gecko) Version/13.0.1 Safari/223.1.15"}

requests.session()
response = requests.post(url, data = {'login':'setlogin', 'password':'setpass'}, headers=headers, allow_redirects=True)
print(response.text)

#file = open('index.html', 'wb')
#pickle.dump(response, file)
