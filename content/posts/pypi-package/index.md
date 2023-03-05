---
title: "How to upload a package to PyPI"
date: 2023-02-26
draft: true

tags: ["Python", "REST API", "PyPI"]
showEdit: false
showTaxonomies: true
---
In this post, I am going to go over the basic steps to uploading a package to the [Python Packaging Index (PyPI)](https://pypi.org/). PyPI is a repository of software for the Python programming language. Uploading a package to PyPi makes it publicly available using Python's built-in package installer pip. Its a great way to make a python project available to other programmers without requiring knowledge of git or GitHub.

## Choosing a project 

PyPI is the perfect platform to upload a tool or abstraction written in Python. Traditionally projects that are going to be packaged make use of object oriented programming to provide end-users with different classes and class methods which are retrievable through dot (.) notation. Technically you can use functional programming in your project but an object oriented approach provides greater flexibility. 

I chose to build a [SDK for Crayon's Cloud-IQ API](https://github.com/blastomussa/crayon-python-sdk) that I wrote into a PyPI package. All of the SDK's logic is under a single class in a single file so it would be a good candidate for a test package upload as it doesn't have the complex file structure of some bigger projects. 


