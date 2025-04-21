import UIKit

class ColorsTableViewController: UIViewController
{
    // Variables
    var colors: [UIColor] = [];
    var namesOfColors: [String] = [];
    
    enum Segue
    {
       static let ColorDetailVC = "ToColorDetailVC" // Esto se hace para no tener errores de escribir mal el String a donde se manda a llamar
    }
    
    enum Cells
    {
        static let colorCell = "ColorCell"
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createArrayOfRandomColors()
    }


    func createArrayOfRandomColors()
    {
        for _ in 0 ..< 50
        {
            colors.append(createRandomColor().color);
            namesOfColors.append(createRandomColor().nombreColor);
        }
    }
    
    func createRandomColor() -> (color: UIColor, nombreColor: String)
    {
        let randomRed = CGFloat.random(in: 0...1.0);
        let randomGreen = CGFloat.random(in: 0...1.0);
        let randomBlue = CGFloat.random(in: 0...1.0);
        let randomColorRGB = String(format: "R: %0.5f, G: %0.5f, B: %0.5f",randomRed,randomGreen,randomBlue);
        let randomColor = UIColor(red: randomRed,
                                  green: randomGreen,
                                  blue:randomBlue,
                                  alpha: 1);
      
        
        return (randomColor, randomColorRGB);
    }
    
    /*
     override func prepare(for segue: UIStoryboardSegue, sender: Any?)
         {
             let destinationVC = segue.destination as! ColorsDetailVC
             destinationVC.color = sender as? UIColor
         }
     }
     */

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == Segue.ColorDetailVC
        {
            guard let destinationVC = segue.destination as? ColorsDetailVC,
                  let (color, name) = sender as? (UIColor, String)
            else { return }
            
            destinationVC.color       = color
            destinationVC.nameOfColor = name
        }
      }

       
    
}

extension ColorsTableViewController:UITableViewDelegate,UITableViewDataSource
{
    //DataSource -> Para saber cuantas lineas tendrá la tabla
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return colors.count;
    }
    
    //delegate methods -> no tienen que esperara a ser llamados para ejecutarse
    // En este caso => Cada vez que una fila aparece en el view, se llama esta funcion :. Por ello es aquí donde se personaliza las celdas
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier:Cells.colorCell )
        else{
            return UITableViewCell()
        }
        

        /* Esta manera tambien funciona pero ya esta obsoleto;
         
         //        let color = colors[indexPath.row]
         //        cell.backgroundColor = color
         //
         //        let textLabel = namesOfColors[indexPath.row]
         //        cell.textLabel?.text = textLabel

         cell.backgroundColor = colors[indexPath.row]
         cell.textLabel?.text = namesOfColors[indexPath.row]
         
         Por eso se usa la manera de abajo ↓:
         */
        
      
        // Le pedimos a la cell una nueva configuración; lo cual regresa una configuración nueva sin contenido dentro de ella
        var content = cell.defaultContentConfiguration()
       
        content.text = namesOfColors[indexPath.row]
        
        // Siempre es necesario esta ↓ linea ya que si no esta; no se aplica las configuraciones
        cell.contentConfiguration = content
        
        // Le pedimos a la cell una nueva configuración; lo cual regresa una configuración nueva sin contenido dentro de ella
        var backGround = UIBackgroundConfiguration.listCell()
        backGround.backgroundColor = colors[indexPath.row]
        backGround.cornerRadius = 10
      
        // Siempre es necesario esta ↓ linea ya que si no esta; no se aplica las configuraciones
        cell.backgroundConfiguration = backGround
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let color = colors[indexPath.row]
        let nameOfColor = namesOfColors[indexPath.row]
        performSegue(withIdentifier: Segue.ColorDetailVC, sender: (color,nameOfColor))
    }

    
}
