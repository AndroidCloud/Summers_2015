#!/usr/bin/env python

from nltk.corpus import wordnet as wn


def getSenseSimilarity(worda,wordb):
	"""
	find similarity betwwn word senses of two words
	"""
	wordasynsets = wn.synsets(worda)
	wordbsynsets = wn.synsets(wordb)
	synsetnamea = [wn.synset(str(syns.name())) for syns in wordasynsets]
	synsetnameb = [wn.synset(str(syns.name())) for syns in wordbsynsets]
	maxim_score = 0;
	for sseta, ssetb in [(sseta,ssetb) for sseta in synsetnamea\
	for ssetb in synsetnameb]:
		wupsim = sseta.wup_similarity(ssetb)
		if wupsim > maxim_score:
			maxim_score = wupsim;
	return maxim_score;


if __name__ == "__main__":
#	a = input(" ");
#	b = input(" ");
	getSenseSimilarity(a,b );
	

