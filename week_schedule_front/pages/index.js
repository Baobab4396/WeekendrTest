function HomePage() {

  return (<div>Bienvenue cher visiteur. Pour un schedule fr ecrire : http://localhost:3000/schedule?locale=fr
    <ul>
      <li>
        Pour ajouter un horaire, lancer la commande curl suivante : curl -v -H "Accept: application/json" -H "Content-Type: application/json" -X POST -d '&#123;"schedule_item":&#123;"shop_name":"loul3", "day_id":1, "open_time":"11:20:29", "close_time":"12:43:23" &#125; &#125;' http://localhost:3001/api/v1/schedule_items
      </li>
    </ul>
  </div>)
}


export default HomePage
