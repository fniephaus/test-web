function copySnippet(elem) {
  const snippet = elem.closest(".snippet-container");
  const text = Array.from(snippet.querySelectorAll("figure"), figure => figure.innerText).join("");
  copyTextToClipboard(text);
}

function copyTextToClipboard(text) {
  const textArea = document.createElement("textarea");
  textArea.style.position = "fixed";
  textArea.style.top = 0;
  textArea.style.left = 0;
  textArea.style.width = "2em";
  textArea.style.height = "2em";
  textArea.style.padding = 0;
  textArea.style.border = "none";
  textArea.style.outline = "none";
  textArea.style.boxShadow = "none";
  textArea.style.background = "transparent";
  textArea.value = text;
  document.body.appendChild(textArea);
  textArea.select();
  try {
    document.execCommand("copy");
  } catch (err) {
    // Clipboard access may be disabled by the browser.
  }
  document.body.removeChild(textArea);
}

async function copyCode(event) {
  const button = event.currentTarget;
  const code = button.parentElement.querySelector("code");
  await navigator.clipboard.writeText(code.innerText);
  button.innerText = "Copied";
  setTimeout(() => { button.innerText = "Copy"; }, 1000);
}

function selected(_value, version) {
  const path = window.location.pathname.split("/");
  path[1] = version;
  window.location.assign(path.join("/"));
}

document.body.classList.remove("preload");
document.querySelectorAll("pre code").forEach(block => hljs.highlightBlock(block));

if (navigator.clipboard) {
  document.querySelectorAll("pre").forEach(block => {
    const button = document.createElement("button");
    button.innerText = "Copy";
    button.addEventListener("click", copyCode);
    block.appendChild(button);
  });
}
