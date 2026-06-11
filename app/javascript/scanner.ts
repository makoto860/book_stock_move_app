import { Html5QrcodeScanner } from "html5-qrcode";

document.addEventListener("turbo:load", () => {
  const reader = document.getElementById("reader");

  if (!reader) {
    return;
  }

  const scanner = new Html5QrcodeScanner(
    "reader",
    {
      fps: 15,
      qrbox: {
        width: 350,
        height: 350,
      },
    },
    false
  );

  scanner.render(
    async (decodedText) => {
     console.log("ISBN:", decodedText);

      console.log("fetch start");

      const response = await fetch(
        `/books/search_by_isbn?isbn=${decodedText}`
      );

      console.log("fetch done");

      const data = await response.json();

      console.log(data);

      const result = document.getElementById("result");

      if (result) {
        result.textContent =
          `ISBN: ${decodedText} / タイトル: ${data.title}`;
      }
    },
    () => {}
  );
});
