# coding: utf-8
#
# W parach stwórzcie model LDA w oparciu o załączone Tweety. W tym celu należy przekonwertować pliki tekstowe na
# reprezentację wektorową zapisując wcześniej mapowanie id->słowo w postaci słownika. Opis jak stworzyć wymienione
# struktury można znaleźć na stronie: https://radimrehurek.com/gensim/tut1.html.

import logging
import gensim
import pandas as pd
import nltk
import string
import re
import stop_words
from collections import Counter


def clean(text):
    text = text.lower()
    text = re.sub(r'[%s]' % re.escape(string.punctuation), '', text)
    text = re.sub(r'\w*\d\w*', '', text)
    text = nltk.word_tokenize(text)
    text = [word for word in text if word not in stop_words.get_stopwords()]
    return text


if __name__ == '__main__':
    logging.basicConfig(format='%(asctime)s : %(levelname)s : %(message)s', level=logging.INFO)

    # TODO 1: Wczytaj tweety z pliku tweets.tsv
    tweets = pd.read_csv("tweets.tsv", sep="\t", header=None, usecols=[2], squeeze=True)

    # TODO 2: odfiltruj słowa, usuń te z stoplisty (stop_words.get_stopwords()) oraz występujące tylko raz
    tweets = tweets[tweets != "Not Available"]
    tweets = tweets.apply(clean)
    counter = Counter(tweets.apply(pd.Series).stack().reset_index(drop=True))
    tweets = tweets.apply(lambda tweet: [word for word in tweet if counter[word] > 1])

    # TODO 3: Stwórz mapowanie/słownik id->słowo
    id2word = gensim.corpora.Dictionary(tweets)

    # TODO 4: Stwórz reprezentację wektorową korpusu (macierz wetkorów TF-IDF)
    mm = [id2word.doc2bow(tweet) for tweet in tweets]

    lda = gensim.models.LdaMulticore(corpus=mm, id2word=id2word, num_topics=10, passes=20)
    lda.print_topics(10)

    # TODO 5*: Na podstawie zbudowanego modelu określ proporcje tematów w następującym tweecie:
    new_tweet = "Zlatan is looking mighty attractive at the moment,if LVG doesn't get a striker by Tuesday," \
                " I really don't fancy us scoring goals this season "

    tweet_bow = id2word.doc2bow(clean(new_tweet))

    for i, score in sorted(lda[tweet_bow], key=lambda x: x[1], reverse=True):
        print("Score: {}\t Topic: {}".format(score, lda.print_topic(i, 5)))

    # Jeśli masz czas, zwiększ wartości parametrów num_topics i  passes przy tworzeniu modelu LDA i sprawdź jak to wpłynie na rezultat
