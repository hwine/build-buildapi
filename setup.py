try:
    from setuptools import setup, find_packages
except ImportError:
    from ez_setup import use_setuptools
    use_setuptools()
    from setuptools import setup, find_packages

setup(
    name='buildapi',
    version='0.1',
    description='',
    author='',
    author_email='',
    url='',
    install_requires=[
        "Pylons>=1.0.0",
        "SQLAlchemy>=0.6",
        "carrot>=0.10.7",
        "pytz",
        "MySQL-python",
    ],
    setup_requires=["PasteScript>=1.6.3"],
    tests_require=["nose", "mock"],
    packages=find_packages(exclude=['ez_setup']),
    include_package_data=True,
    test_suite='nose.collector',
    package_data={'buildapi': ['i18n/*/LC_MESSAGES/*.mo']},
    #message_extractors={'buildapi': [
    #        ('**.py', 'python', None),
    #        ('templates/**.mako', 'mako', {'input_encoding': 'utf-8'}),
    #        ('public/**', 'ignore', None)]},
    zip_safe=False,
    paster_plugins=['PasteScript', 'Pylons'],
    entry_points="""
    [paste.app_factory]
    main = buildapi.config.middleware:make_app

    [paste.app_install]
    main = pylons.util:PylonsInstaller

    [console_scripts]
    selfserve-agent = buildapi.scripts.selfserve_agent:main
    """,
)
