using CadRestaurante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnRestaurante
{
    public class FacturaCln
    {
        public static int insertar(Factura factura)
        {
            using (var context = new RestauranteEntities())
            {
                context.Factura.Add(factura);
                context.SaveChanges();
                return factura.id;
            }
        }

        public static int actualizar(Factura factura)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Factura.Find(factura.id);
                existente.idCliente = factura.idCliente;
                existente.fecha = factura.fecha;
                existente.usuarioRegistro = factura.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Factura.Find(id);
                existente.estado = -1;
                existente.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static Factura get(int id)
        {
            using (var context = new RestauranteEntities())
            {
                return context.Factura.Find(id);
            }
        }

        public static List<Factura> listar()
        {
            using (var context = new RestauranteEntities())
            {
                return context.Factura.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paFacturaListar_Result> listarPa(string parametro)
        {
            using (var context = new RestauranteEntities())
            {
                return context.paFacturaListar(parametro).ToList();
            }
        }
    }
}

