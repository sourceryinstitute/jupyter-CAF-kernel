from setuptools import setup

setup(name='jupyter_caf_kernel',
      version='0.1.0',
      description='Coarray Fortran kernel for Jupyter',
      author='Izaak Beekman',
      author_email='contact@izaakbeekman.com',
      url='https://github.com/sourceryinstitute/jupyter-CAF-kernel/',
      download_url='https://github.com/sourceryinstitute/jupyter-CAF-kernel/releases/latest',
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
      ],
      packages=['jupyter_caf_kernel'],
      keywords=['jupyter', 'kernel', 'fortran', 'coarrays']
)
