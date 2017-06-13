from setuptools import setup

setup(name='jupyter-CAF-kernel',
      version='0.1.0',
      description='Minimalistic Coarray Fortran kernel for Jupyter',
      long_description='Minimalistic OpenCoarrays/GFortran based Coarray Fortran kernel for Jupyter',
      author='Izaak Beekman',
      author_email='contact@izaakbeekman.com',
      url='https://github.com/sourceryinstitute/jupyter-CAF-kernel',
      download_url='https://github.com/sourceryinstitute/jupyter-CAF-kernel',
      license='MIT',
      classifiers=[
          'Development Status :: 3 - Alpha',
          'Framework :: Jupyter',
          'License :: OSI Approved :: MIT License',
          'Programming Language :: Python :: 2',
          'Programming Language :: Python :: 2.6',
          'Programming Language :: Python :: 2.7',
          'Programming Language :: Python :: 3',
          'Programming Language :: Python :: 3.3',
          'Programming Language :: Python :: 3.4',
          'Programming Language :: Python :: 3.5',
          'Programming Language :: Fortran',
          'Topic :: Scientific/Engineering',
      ],
      packages=['jupyter-CAF-kernel'],
      keywords=['jupyter', 'kernel', 'fortran', 'coarray', 'CAF', 'coarray-fortran']
)
