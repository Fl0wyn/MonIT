/* Convert byte */
export const convertByte = (a, d = 1, k = 1024) => {
  const i = Math.floor(Math.log(a) / Math.log(k));
  return (
    parseFloat((a / Math.pow(k, i)).toFixed(d)) +
    " " +
    ["o", "Ko", "Mo", "Go", "To"][i]
  );
};

/* Convert bandwidth  */
export const convertBandwidth = (a, d = 2, k = 125000) => {
  return parseFloat((a / k).toFixed(d)) + " Mbps";
};

/* Convert date */
export const convertDate = (fulldate) => {
  const x = fulldate;

  // Date
  const a = x.substr(0, 8);
  const jour = a.substr(6);
  const mois = a.substr(4, 6).substr(0, 2);
  const annee = a.substr(0, 4);

  // Heure
  const heure = x.substr(8, 2);
  const minute = x.substr(10, 2);

  return jour + "/" + mois + "/" + annee + "\n" + " " + heure + ":" + minute;
};
