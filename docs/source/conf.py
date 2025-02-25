# Configuration file for the Sphinx documentation builder.
#
# For the full list of built-in configuration values, see the documentation:
# https://www.sphinx-doc.org/en/master/usage/configuration.html

# -- Project information -----------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#project-information
import os
import sys

project = 'PCSSP'
copyright = '2025, ITER Organization'
author = 'ITER Organization'
release = '1'

# -- General configuration ---------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration

extensions = ['sphinx.ext.autodoc','sphinxcontrib.matlab','sphinx.ext.napoleon']
sys.path.insert(0, os.path.abspath('../..'));
this_dir = os.path.dirname(os.path.abspath(__file__))
matlab_src_dir = os.path.abspath(os.path.join(this_dir,'..','..'))
primary_domain = 'mat'

templates_path = ['_templates']
exclude_patterns = []



# -- Options for HTML output -------------------------------------------------
# https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output

html_theme = 'alabaster'
html_theme_options = {
    'github_user': 'iterorganization',
    'github_repo': 'PCSSP',
    'github_button': 'true',
    'github_banner': 'true',
    'description': 'The Simulink-based Plasma Control System Simulation Platform',
    'page_width': '85%',
    'sidebar_width': '20%'
}
html_static_path = ['_static']
