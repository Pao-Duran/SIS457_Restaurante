using CadRestaurante;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ClnRestaurante
{
    public class PlatosCln
    {
        public static int insertar(Platos platos)
        {
            using (var context = new RestauranteEntities())
            {
                context.Platos.Add(platos);
                context.SaveChanges();
                return platos.id;
            }
        }

        public static int actualizar(Platos platos)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Platos.Find(platos.id);
                existente.nombre = platos.nombre;
                existente.precio = platos.precio;
                existente.usuarioRegistro = platos.usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static int eliminar(int id, string usuarioRegistro)
        {
            using (var context = new RestauranteEntities())
            {
                var existente = context.Platos.Find(id);
                existente.estado = -1;
                existente.usuarioRegistro = usuarioRegistro;
                return context.SaveChanges();
            }
        }

        public static Platos get(int id)
        {
            using (var context = new RestauranteEntities())
            {
                return context.Platos.Find(id);
            }
        }

        public static List<Platos> listar()
        {
            using (var context = new RestauranteEntities())
            {
                return context.Platos.Where(x => x.estado != -1).ToList();
            }
        }

        public static List<paPlatoListar_Result> listarPa(string parametro)
        {
            using (var context = new RestauranteEntities())
            {
                return context.paPlatoListar(parametro).ToList();
            }
        }
    }
}
