from setuptools import setup

setup(name='jupyter_caf_kernel',
      version='0.1.0',
      description='Minimalistic Fortran kernel for Jupyter',
      author='Peter Hill',
      author_email='peter@fusionplasma.co.uk',
      url='https://github.com/ZedThree/jupyter-fortran-kernel/',
      download_url='https://github.com/ZedThree/jupyter-fortran-kernel/tarball/0.1.0',
      license='MIT',
      classifiers=[
          'Development Status :: 3 - Alpha',
          'Framework :: IPython',
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
      keywords=['jupyter', 'kernel', 'fortran']
)
