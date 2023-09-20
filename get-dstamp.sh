curl -s https://api.github.com/repos/YosysHQ/oss-cad-suite-build/releases/latest | grep browser_download_url | grep linux-x64 | grep -Po '\d{8}(?=.tgz)'
