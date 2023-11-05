using CadRestaurante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnRestaurante
{
    public class DetalleFacturaCln
    {
        public static int insertar(detalleFactura detalleFactura)
        {
            using (var context = new RestauranteEntities())
            {
                context.detalleFactura.Add(detalleFactura);
                context.SaveChanges();
                return detalleFactura.id;
            }
        }

        public static int actualizar(detalleFactura detalleFactura)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.detalleFactura.Find(detalleFactura.id);
                existente.idFactura = detalleFactura.idFactura;
                existente.idEmpleado = detalleFactura.idEmpleado;
                existente.idPlato = detalleFactura.idPlato;
                existente.idMesa = detalleFactura.idMesa;
                existente.usuarioRegistro = detalleFactura.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.detalleFactura.Find(id);
                existente.estado = -1;
                existente.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static detalleFactura get(int id)
        {
            using (var context = new RestauranteEntities())
            {
                return context.detalleFactura.Find(id);
            }
        }

        public static List<detalleFactura> listar()
        {
            using (var context = new RestauranteEntities())
            {
                return context.detalleFactura.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paDetalleFacturaListar_Result> listarPa(string parametro)
        {
            using (var context = new RestauranteEntities())
            {
                return context.paDetalleFacturaListar(parametro).ToList();
            }
        }
    }
}

