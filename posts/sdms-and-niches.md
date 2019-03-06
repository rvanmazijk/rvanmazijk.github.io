---
title: "What determines a species range? Thoughts about SDMs and niches"
---

I’ve been thinking a lot about species distribution models, and biogeography in general, lately.

What determines a species’ range? Well, according to Heads (2015):

> Current ecological processes explain distribution at smaller scales than do biogeographical and evolutionary processes, but the latter can lead to patterns that are much more local than many ecologists have assumed. 

> […] the chasm between the work on distribution produced by ecologists and the biogeography produced by systematists and phylogeneticists. As Wiens (2011) pointed out, many ecological papers that aim to explain species diversity and distribution ignore evolutionary aspects of the patterns altogether. 

> […] It has been known since ancient times that the distribution of plants and animals is related to climate. The broad vegetation types or biomes – forest, woodland, grassland and desert – reflect climate, and in colder or drier areas the community shifts towards the desert end of the spectrum. Plants with different physiognomy, or the gross structure, occur in different biomes. 

> […] systematists discovered that underlying the biomes is a global pattern of differentiation in the clades, as summarized in schemes of biogeographical boundaries and regions. This work culminated in the recognition of global boundaries that affect many groups, but show no obvious correlation with climate, soil type or any other feature of the physical environment. Wallace’s line is the best known, but there are many similar cases (Heads, 2012). Thus the age of exploration led to the discovery that many different areas of the Earth had different creatures, even though they had similar climates.

So, essentially, ecology and history determine biogeography. As Heads points out, species distribution models (SDMs) or ecological niche models (ENMs) are known to misestimate species ranges. These models are ahistorical, and have problems besides this. I have used SDMs before, and quite extensively in one project. I found that the changes in species range in Proteaceae, as projected under climate change with SDMs, exhibited intra-generic patterns, but were highly variable in species-rich genera. Now, the findings that work in my third year, and the vast amount of work worldwide that has used SDMS, is impacted by any discussion of the efficacy of SDMs.

There is debate as to whether SDMs and ENMs are designed to predict a species distribution, or estimate the species’ response to environmental gradients (its niche). Either way, SDMs and ENMs used the environmental values at sites of a species’ occurrence to estimate the parameters of the effect of different environmental axes on occurrence. (Heads 2015)

However, quantitatively describing niches from geographic data is something that has been on my mind lately—and how I think it may not necessarily effective. It is unclear whether the environment of the range has shaped the species’ niche, or vice versa (Heads 2015). In the case of the latter, a species’ niche and ecology are the sole determinants of its range (one mustn’t forget dispersal and vicariance) (Heads 2015). Also, there is startling new evidence that estimating a species’ niche from the environmental values at sites of its occurrence can lead to predictions no better than those because of spatial autocorrelation in environmental variables alone (Boucher-Lalonde & Currie 2016). The rationale of this findng was difficult for me to wrap my head around, but I believe the argument is as follows: when using the occurrence locations of a species as the sources of the climatic data as well, one loses statistical independence for the climatic (and other environmental) data, as these layers are often spatially autocorrelated. Spurious correlations may be found when comparing two spatially autocorrelated layers (e.g. species range and temperature could each be spatially autocorrelated layers).

I recently attended a seminar by [Associate Professor Bethany A. Bradley](https://scholar.google.com/citations?user=qw0uxPMAAAAJ), from UMass, Amherst. It was an exceptionally interesting talk, with much bearing on my thoughts here. In it, she described her findings from studies involving SDMs for invasive and native plant species in the US. She found that at regional scales, native species are unlikely to be at climatic equilibrium, and do not usually fill the potential range predicted by SDMs informed by their native ranges (Bradley et al., 2015). She also found that SDMs of small ranging species are likely to underestimate the fundamental suitable climate space, and thus potential range, of that species (Bocsi et al. 2016). In other words, species may well have environmental tolerances beyond that experiences in their native ranges.

So, describing species’ niches, and explaining distributions from an ecological standpoint, based on where species occur can go wrong in multiple places. These have been some of my thoughts while I draft my thesis proposal for next year. It is interesting to me that modeling biological phenomena as fundamental as species’ ranges and niches is not straightforward, and in fact very complex. I hope to attempt to tackle such complexity next year, and am healthily nervous about doing so, but also extremely excited.

I have a perhaps naïve idea for measuring a species fundamental niche. More specifically to my interests, how to estimate edapho-climatic niches in plants. Is there way to gauge the optimality of an environment for a species in situ? A natural experiment may be the answer—as opposed to laboratory growth experiments. Perhaps one could sample plant size/health/fitness/etc. (calibrated appropriately by age?) along various environmental gradients (e.g. rainfall, temperature, and soil gradients within a species’ range). Thus, one could infer more of the fundamental niche from observation alone. This can be applied to animals too; I see no reason for it not to be. Instead of simple occurrence data along environmental gradients (the realised niche), one could infer the fundamental niche. For example, say that as the optima within the realised niche is nearer the extremes of the realised niche. Then the fundamental niche may be markedly different to and extend beyond the realised niche.

Perhaps my suggestions are naïve, but my judgement at the moment is that there are considerations to be made (above) when describing a species’ niche from observations. And the fundamental niche is, as I understand, what can evolve. This is a particularly interesting avenue of questions, for me personally. Not least in phylogenetic contexts, but also for conservation in the face of climate change. This also interesting, as phylogenetic information has value in climate change planning (Davis et al. 2010; Rafferty et al. 2016). One could, conceivably, make useful generalisations about the effect of climate change on clades, or see which clades are more at risk, both ecologically and in terms of range shifts and declines. And it would be very cool to discover phylogenetic patterns in the effects of climate change on biota.

---Ruan

---

## References

Bocsi, T., Allen, J.M., Bellemare, J., Kartesz, J., Nishino, M. and Bradley, B.A., 2016. Plants' native distributions do not reflect climatic tolerance. *Diversity and Distributions*.

Boucher-Lalonde V. and Currie D.J., 2016. Spatial Autocorrelation Can Generate Stronger Correlations between Range Size and Climatic Niches Than the Biological Signal---A Demonstration Using Bird and Mammal Range Maps. *PLoS ONE* 11(11): e0166243. DOI:10.1371/journal.pone.0166243

Bradley, B.A., Early, R. and Sorte, C.J., 2015. Space to invade? Comparative range infilling and potential range of invasive and native plants. *Global Ecology and Biogeography*, 24(3): 348---359.

Heads, M., 2015. The relationship between biogeography and ecology: envelopes, models, predictions. *Biological Journal of the Linnean Society*, 115(2): 456---468.
