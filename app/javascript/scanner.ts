import { Html5QrcodeScanner } from "html5-qrcode";

const scanner = new Html5QrcodeScanner(
  "reader",
  {
    fps: 10,
    qrbox: 250,
  },
  false
);

scanner.render(
  (decodedText) => {
    console.log("ISBN:", decodedText);
  },
  (error) => {
    console.log(error);
  }
);
