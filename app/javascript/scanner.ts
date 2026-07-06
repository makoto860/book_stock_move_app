import { Html5QrcodeScanner } from "html5-qrcode";

document.addEventListener("turbo:load", () => {
  const reader = document.getElementById("reader");

  if (!reader) { return; }

  const scanner = new Html5QrcodeScanner(
    "reader", { fps: 15, qrbox: { width: 450, height: 450, }, }, false
  );

  scanner.render(
    async (decodedText) => {
     console.log("ISBN:", decodedText);
      await scanner.clear();

      const response = await fetch( `/books/search_by_isbn?isbn=${decodedText}` );
      const data = await response.json();
      const result = document.getElementById("result");

      if (result) {
        result.textContent = `ISBN: ${decodedText} / タイトル: ${data.title}`;
      }
    }, () => {}
  );
});
