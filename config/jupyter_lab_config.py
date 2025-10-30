c.ServerApp.ip = '0.0.0.0'
c.ServerApp.password = u''
c.ServerApp.password_required = False
c.ServerApp.token=''
c.ServerApp.open_browser = False
c.NotebookApp.enable_mathjax = False
c.ServerApp.allow_root = True
c.ServerApp.port = 9090
c.ServerApp.root_dir = '/workspace/'
c.ContentsManager.allow_hidden = True

c.MappingKernelManager.cull_idle_timeout = 64800
c.MappingKernelManager.cull_interval = 60
c.MappingKernelManager.cull_connected = True

c.ContentsManager.checkpoints_kwargs = {"root_dir": "/tmp/.jupyterlab"}
c.FileContentsManager.checkpoints_kwargs = {"root_dir": "/tmp/.jupyterlab"}
