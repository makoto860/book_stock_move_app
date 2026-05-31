import { Html5QrcodeScanner } from "html5-qrcode";

const scanner = new Html5QrcodeScanner(
  "reader",
  {
    fps: 10,
    qrbox: {
      width: 250,
      height: 250,
    },
  },
  false
);

scanner.render(
  (decodedText) => {
    console.log("ISBN:", decodedText);

    const result = document.getElementById("result");

    if (result) {
      result.textContent = `ISBN: ${decodedText}`;
    }
  },
  (error) => {
    console.log(error);
  }
);
