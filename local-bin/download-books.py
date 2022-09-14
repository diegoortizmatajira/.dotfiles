#!/usr/bin/env python3
import sys
from bs4 import BeautifulSoup
import requests
from colorama import Fore, Style

ZLIB = 'https://z-lib.org'
GOODREADS = 'https://www.goodreads.com'
BOOK_LIMIT = 5


def get_filter(book: str, author: str = None):
    return book + ('' if author == None else ' '+author)


def main(book: str, author: str = None):
    base_url = search_zlib_base_url()
    filter = get_filter(book, author)
    books_in_serie = search_goodreads_books_in_series(filter)
    if books_in_serie == None:
        search_zlib_book(base_url, filter)
    else:
        for book_in_serie in books_in_serie:
            search_zlib_book(
                base_url, book_in_serie['filter'], book_in_serie['number'])


def search_goodreads_book(filter: str):
    response = requests.get(f"{GOODREADS}/search?q={filter}&qid=")
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    books_link = soup.find('a', attrs={'class': 'bookTitle'})
    if books_link == None:
        return None
    return books_link['href']


def search_goodreads_series(filter: str):
    url = search_goodreads_book(filter)
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


def search_goodreads_books_in_series(filter: str):
    series_url = search_goodreads_series(filter)
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
        author = header.find('span', attrs={'itemprop': 'author'})
        result.append({
            'filter': get_filter(title.text.strip(), author.text.strip()),
            'number': number.text.strip(),
        })
    return result


def search_zlib_base_url():
    response = requests.get(ZLIB)
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    books_link = soup.find('a', text='Books', attrs={'class': 'domain-check-link'
                                                     })
    if books_link == None:
        return None
    url = books_link['href']
    return 'https:' + url if url[:2] == "//" else url


def search_zlib_book(base_url: str, filter: str, prefix: str = None):
    url = f"{base_url}/s/{filter}/?e=1&extensions[]=epub"
    response = requests.get(url)
    soup = BeautifulSoup(response.text, 'html.parser')
    if soup == None:
        return None
    entries = soup \
        .find_all('tr', attrs={'class': 'bookRow'}, limit=BOOK_LIMIT)
    if len(entries) == 0:
        return
    if prefix != None:
        print(f"{Fore.WHITE}*****************************")
        print(f"[{prefix} - {filter}]")
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
        title = sys.argv[1]
        author = None
        if len(sys.argv) > 2:
            author = sys.argv[2]
        main(title, author)
