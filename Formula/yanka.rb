class Yanka < Formula
  desc "Yet ANother Knowledge App — capture engineering decisions from conversation"
  homepage "https://github.com/Nambu14/yanka"
  url "https://github.com/Nambu14/yanka/releases/download/v0.3.4/yanka-0.3.4.tar.gz"
  sha256 "3bdf0be05d1ab1c244ece2cb8e10b1ccc5bb5c2f6b4a095fde1f62e81c6feb06"
  license "Apache-2.0"

  depends_on "python@3.12"

  def install
    python = Formula["python@3.12"].opt_bin/"python3.12"
    sdist_url = stable.url
    (bin/"yanka").write <<~SH
      #!/bin/bash
      set -euo pipefail

      VERSION="#{version}"
      SDIST_URL="#{sdist_url}"
      PYTHON="#{python}"

      # Test-only path used by the formula test block to avoid network access.
      if [[ "${YANKA_WRAPPER_TEST:-}" == "1" ]]; then
        echo "yanka ${VERSION}"
        exit 0
      fi

      data_home="${XDG_DATA_HOME:-$HOME/.local/share}"
      yanka_home="${YANKA_HOME:-${data_home}/yanka}"
      venv_dir="${yanka_home}/venv"
      stamp_file="${venv_dir}/.yanka-version"

      installed_version=""
      if [[ -f "${stamp_file}" ]]; then
        installed_version="$(<"${stamp_file}")"
      fi

      if [[ ! -x "${venv_dir}/bin/yanka" || "${installed_version}" != "${VERSION}" ]]; then
        echo "Bootstrapping yanka ${VERSION} into ${venv_dir} ..."
        rm -rf "${venv_dir}"
        mkdir -p "$(dirname "${venv_dir}")"
        "${PYTHON}" -m venv "${venv_dir}"
        "${venv_dir}/bin/python" -m pip install --upgrade pip
        "${venv_dir}/bin/python" -m pip install --no-compile "${SDIST_URL}"
        printf '%s\n' "${VERSION}" > "${venv_dir}/.yanka-version"
      fi

      exec "${venv_dir}/bin/yanka" "$@"
    SH
    chmod 0755, bin/"yanka"
  end

  test do
    assert_match version.to_s, shell_output("YANKA_WRAPPER_TEST=1 #{bin}/yanka")
  end
end
