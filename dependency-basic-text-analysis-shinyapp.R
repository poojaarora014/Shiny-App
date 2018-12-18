#Team Name:
# Pooja Arora (RollNo. 11810083)
# Vikash Singh Negi (RollNo. 11810048)

#Installing required packages for this Shiny App

if (!require(udpipe)){install.packages("udpipe")}
if (!require(textrank)){install.packages("textrank")}
if (!require(lattice)){install.packages("lattice")}
if (!require(igraph)){install.packages("igraph")}
if (!require(ggraph)){install.packages("ggraph")}
if (!require(stringr)){install.packages("stringr")}
if (!require(ggplot2)){install.packages("ggplot2")}

# Importing required packages for executing current Shiny APP

library(shiny)
library(udpipe)
library(textrank)
library(lattice)
library(igraph)
library(ggraph)
library(ggplot2)
library(stringr)
