#!/usr/bin/env python

server = 'http://localhost:3000'

import requests
import json
import string
import random

def id_generator(size=6, chars=string.ascii_uppercase + string.digits):
  return ''.join(random.choice(chars) for x in range(size))

def print_and_parse(response):
  print response.request.method + ': ' + response.url
  print "    " + json.dumps(response.request.data)
  print " -> " + response.text
  print " () " + json.dumps(requests.utils.dict_from_cookiejar(response.cookies))
  return json.loads(response.text)

def signup(session):
  user_params = {
      'user[login]': id_generator(),
      'user[password_verifier]': '12345',
      'user[password_salt]': '54321'
      }
  return session.post(server + '/users.json', data = user_params)

def authenticate(session, login):
  params = {
      'login': login,
      'A': '12345',
      }
  init = session.post(server + '/sessions', data = params)
  cookies = requests.utils.dict_from_cookiejar(init.cookies)
  init = session.post(server + '/sessions', data = params, cookies = cookies)
  print "(%) " + json.dumps(cookies)
  return session.put(server + '/sessions/' + login, data = {'M': '123'}, cookies = cookies)

session = requests.session()
user = print_and_parse(signup(session))
# SRP signup would happen here and calculate M hex
auth = print_and_parse(authenticate(session, user['login']))
