import { useRouter } from 'next/router'

function Schedule({ data }) {

  // On récupère les paramètres fourni dans l'URL, notamment la local pour l'internationalisation.
  const router = useRouter()
  const {locale} = router.query

  const renderItems = []
  // Notre json, généré par le back en Ruby On Rails est retransformé en dictionnaire.
  const obj = JSON.parse(data["schedule"]);

  const daysEn = {
      0: "Sunday",
      1: "Monday",
      2: "Tuesday",
      3: "Wednesday",
      4: "Thursday",
      5: "Friday",
      6: "Saturday"
  };

  const daysFr = {
      0: "Dimanche",
      1: "Lundi",
      2: "Mardi",
      3: "Mercredi",
      4: "Jeudi",
      5: "Vendredi",
      6: "Samedi"
  };

  // Selon la langue spécifié dans l'URL, on choisit soit la langue de Molière soit celle de Shakespeare.
  if (typeof locale === 'undefined'){
      var days = daysFr;
      var closed = "Fermé"
  }
  else if(locale.includes("fr")){
      var days = daysFr;
      var closed = "Fermé"
  }
  else{
      var days = daysEn;
      var closed = "Closed"
  }

  // For débuguingue purpose
  console.log(obj)
  const currentDay = new Date();
  for (var i = currentDay.getDay(); i < currentDay.getDay() + 7; i++) {
    var iMod = i%7
    if(i === currentDay.getDay()){
      // Pour le jour d'aujourd'hui , on lui donne un traitement spécial à base de style gras et italique, et placé en pôle position des plages horaires.
      renderItems.unshift(<li key={iMod}><b><i>{days[iMod]} : {obj[iMod] === "null" ? closed : obj[iMod]}</i></b></li>)
    }
    else{
      renderItems.push(<li key={iMod}>{days[iMod]} : {obj[iMod] === "null" ? closed : obj[iMod]}</li>)
    }
  }

  // On ajoute un petit titre pour voir quelle boutique on affiche son emploi du temps.
  renderItems.unshift(<h1 key="{item}" >Emploi du temps de la boutique : {data["shop_name"]}</h1>)

  return <div>{renderItems}</div>
}

// This gets called on every request
export async function getServerSideProps() {
  // Fetch data from external API
  // Remplacer loul3 par le nom de la boutique dont on veut obtenir l'emploi du temps
  // Si nécessaire, faire un curl (cf. index.js ou README.md pour plus d'info)
  const res = await fetch(`http://127.0.0.1:3001/api/v1/week_schedules/loul3`)
  const data = await res.json()

  // Pass data to the page via props
  return { props: { data } }
}

export default Schedule
