#!/usr/bin/env python
import sys
from bs4 import BeautifulSoup
import requests
from colorama import Fore, Style

GOODREADS = 'https://www.goodreads.com'


def main(book: str):
    base_url = search_zlib_base_url()
    books_in_serie = search_goodreads_books_in_series(book)
    if books_in_serie == None:
        search_zlib_book(base_url, book)
    else:
        for book_in_serie in books_in_serie:
            search_zlib_book(
                base_url, book_in_serie['name'], book_in_serie['number'])


def search_goodreads_book(book: str):
    response = requests.get(f"{GOODREADS}/search?q={book}&qid=")
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    books_link = soup.find('a', attrs={'class': 'bookTitle'})
    if books_link == None:
        return None
    return books_link['href']


def search_goodreads_series(book: str):
    url = search_goodreads_book(book)
    response = requests.get(f'{GOODREADS}{url}')
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    series_header = soup.find('h2', attrs={'id': 'bookSeries'})
    if series_header == None:
        return None
    series_link = series_header.find('a')
    if series_link == None:
        return None
    return series_link['href']


def search_goodreads_books_in_series(book: str):
    series_url = search_goodreads_series(book)
    if series_url == None:
        return None
    response = requests.get(f'{GOODREADS}{series_url}')
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    result = []
    headers = soup.find_all('div', attrs={'class': 'listWithDividers__item'})
    for header in headers:
        number = header.find('h3', attrs={'class': 'gr-h3'})
        title = header.find('span', attrs={'itemprop': 'name'})
        result.append({
            'name': title.text.strip(),
            'number': number.text.strip(),
        })
    return result


def search_zlib_base_url():
    response = requests.get('https://z-lib.org')
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    books_link = soup.find('a', text='Books', attrs={
                           'class': 'domain-check-link'})
    if books_link == None:
        return None
    url = books_link['href']
    return 'https:' + url if url[:2] == "//" else url


def search_zlib_book(base_url: str, book: str, prefix: str = None):
    url = f"{base_url}/s/{book}/?e=1&extensions[]=epub"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    entries = soup \
        .find_all('tr', attrs={'class': 'bookRow'}, limit=5)
    if prefix != None:
        print(f"{Fore.WHITE}*****************************")
        print(f"[{prefix} - {book}]")
        print(f"{Fore.WHITE}*****************************{Style.RESET_ALL}")
    for entry in entries:
        title_section = entry.find('h3', attrs={'itemprop': 'name'})
        title_link = title_section.find('a')
        title = title_link.text.strip()
        author = entry \
            .find('div', attrs={'class': 'authors'}) \
            .text.strip()

        file_section = entry.find('div', attrs={'class': 'property__file'})
        file_size = file_section \
            .find('div', attrs={'class': 'property_value'}) \
            .text.strip()
        print(f"{Fore.BLUE}{title}")
        print(f"{Fore.CYAN}{author}{Style.RESET_ALL}")
        print(
            f"[{file_size}]{Style.RESET_ALL} => {Fore.GREEN}{base_url}{title_link['href']}{Style.RESET_ALL}")
        print(f"{Style.DIM}---------------------------{Style.RESET_ALL}")


if __name__ == '__main__':
    if len(sys.argv) <= 1:
        print('You need to provide a book name')
        exit
    else:
        main(sys.argv[1])
