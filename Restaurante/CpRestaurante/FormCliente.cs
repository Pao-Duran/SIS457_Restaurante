using CadRestaurante;
using ClnRestaurante;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace CpRestaurante
{
    public partial class FormCliente : Form
    {
        bool esNuevo = false;
        public FormCliente()
        {
            InitializeComponent();
        }
        private void listar()
        {
            var clientes = ClienteCln.listarPa(txtParametro.Text.Trim());
            dgvLista.DataSource = clientes;
            dgvLista.Columns["id"].Visible = false;
            dgvLista.Columns["nombre"].HeaderText = "Nombre";
            dgvLista.Columns["primerapellido"].HeaderText = "Primer Apellido";
            dgvLista.Columns["segundoapellido"].HeaderText = "Segundo Apellido";
            dgvLista.Columns["cedulaidentidad"].HeaderText = "Cedula de Identidad";
            dgvLista.Columns["telefono"].HeaderText = "Telefono";
           
            btnEditar.Enabled = clientes.Count > 0;
            btnEliminar.Enabled = clientes.Count > 0;
            if (clientes.Count > 0) dgvLista.Rows[0].Cells["nombre"].Selected = true;
        }
        private void lblTitulo_Click(object sender, EventArgs e)
        {

        }

        private void btnNuevo_Click(object sender, EventArgs e)
        {
            esNuevo = true;
            Size = new Size(830, 462);
            txtNombre.Focus();
        }

        private void btnEditar_Click(object sender, EventArgs e)
        {

            esNuevo = false;
            Size = new Size(830, 462);

            int index = dgvLista.CurrentCell.RowIndex;
            int id = Convert.ToInt32(dgvLista.Rows[index].Cells["id"].Value);
            var cliente = ClienteCln.get(id);
            txtNombre.Text = cliente.nombre;
            txtPrimerApellido.Text = cliente.primerApellido;
            txtSegundoApellido.Text = cliente.segundoApellido;
            txtCedulaIdentidad.Text = cliente.cedulaIdentidad;
            txtTelefono.Text = cliente.telefono;

        }

        private void btnEliminar_Click(object sender, EventArgs e)
        {

        }

        private void btnCerrar_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            Size = new Size(830, 347);
            limpiar();
        }
        private void limpiar()
        {
            txtNombre.Text = string.Empty;
            txtPrimerApellido.Text = string.Empty;
            txtSegundoApellido.Text = string.Empty;
            txtCedulaIdentidad.Text = string.Empty;
            txtTelefono.Text = string.Empty;


        }

        private void btnGuardar_Click(object sender, EventArgs e)
        {
            var cliente = new Cliente();
            cliente.nombre = txtNombre.Text.Trim();
            cliente.primerApellido = txtPrimerApellido.Text.Trim();
            cliente.segundoApellido = txtSegundoApellido.Text.Trim();
            cliente.cedulaIdentidad = txtCedulaIdentidad.Text.Trim();
            cliente.telefono = txtTelefono.Text.Trim();


            if (esNuevo)
            {
                cliente.fechaRegistro = DateTime.Now;
                cliente.estado = 1;
                ClienteCln.insertar(cliente);
            }
            else
            {
                int index = dgvLista.CurrentCell.RowIndex;
                cliente.id = Convert.ToInt32(dgvLista.Rows[index].Cells["id"].Value);
                ClienteCln.actualizar(cliente);
            }
            listar();
            btnCancelar.PerformClick();
            MessageBox.Show("Producto guardado correctamente", "::: Minerva - Mensaje :::",
                MessageBoxButtons.OK, MessageBoxIcon.Information);
        }
    }
}