#!/usr/bin/env python
# encoding: utf-8
"""
scraper.py

Created by Maxime Santerre on 2011-11-25.
"""

import sys
import os
from urllib2 import Request, urlopen
from BeautifulSoup import BeautifulSoup
from redis import Redis
import json

class Scraper:
	def __init__(self, base):
		self.base = base
	
	def scrape(self, sub, pages):
		for page in pages:
			url = "{base}/{sub}/{page}".format(base = self.base,
												sub = sub,
												page = page)
			print "Getting data from {0}".format(url)
			request = Request(url)
			html = urlopen(request).read()
			yield html
			
	def parse(self, html, tag):
		soup = BeautifulSoup(html)
		return soup.findAll(tag, align='left')


if __name__ == '__main__':
	host = "http://boards.4chan.org"
	red = Redis(host="localhost", port=28765)
	
	sets = json.loads(open("config/4chan.json").read())
	all_sets = sets['NSFW_SETS'] + sets["SFW_SETS"]
	
	for sub in all_sets:
		scraper = Scraper(host)
		for result in scraper.scrape(sub, range(8)):
			soup = BeautifulSoup(result)
			for image in soup.findAll('img', align="left"):
				print image['src']
				red.sadd(sub, image['src'])
