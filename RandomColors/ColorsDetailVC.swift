import UIKit

class ColorsDetailVC: UIViewController
{
    
    var color: UIColor?
    var nameOfColor: String?
    
    var nombreSeparado: [Any?] = []
    
//    var radomRedValue : String
//    var radomGreenValue : String
//    var radomBlueValue : String
//    
  
    @IBOutlet weak var redValue: UILabel?
    @IBOutlet weak var greeValue: UILabel?
    @IBOutlet weak var blueValue: UILabel?
    
    @IBAction func copiarRGB(_ sender: UIButton)
    {
        UIPasteboard.general.string = nameOfColor
        sender.setTitle("✔️", for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                sender.setTitle("💾", for: .normal)
            }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = color ?? .white // solo se pone.white porque se sabe que es tipoUIColor
        
        
        guard let nameOfColor = nameOfColor else { return }
//        nombreSeparado = nameOfColor.split(separator: ",")
//       if nombreSeparado.count >= 3
//        {
        redValue?.text = "Red Value:  \(nameOfColor.substring(desde: 3, hasta: 10))"
           greeValue?.text = "Green Value: \(nameOfColor.substring(desde: 15, hasta: 22))"
           blueValue?.text = "Blue Value: \(nameOfColor.substring(desde: 27, hasta:34 ))"
//       }
    }
}

extension String {
    /// Devuelve la subcadena que va desde `from`(inclusive) hasta `to` (exclusive).
    /// - Parámetros:
    ///   - from: índice de inicio (0-based)
    ///   - to: índice de fin (0-based, no incluido)
    /// - Retorna: el fragmento como `String`, o string vacío si los índices quedan fuera de rango.
    func substring(desde from: Int,hasta to: Int) -> String {
        // Asegurarnos de que from y to quedan entre 0 y count
        let start = max(0, min(from, count))
        let end = max(0, min(to, count))

        // Obtener los índices de tipo String.Index
        let startIndex = index(self.startIndex, offsetBy: start)
        let endIndex   = index(self.startIndex, offsetBy: end)

        // Extraer el rango y convertir a String
        return String(self[startIndex ..< endIndex])
    }
}

