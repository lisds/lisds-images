# Configuration file for jupyterhub.
c = get_config()  #noqa

c.Spawner.args = ['--NotebookApp.show_banner=False']
