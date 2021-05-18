import React from "react";
import Modal from 'react-bootstrap/Modal'

export const ModalComponent = ({title, children, show, onHide}: any) => {
  return (
    <Modal show={show} onHide={onHide} centered>
      <Modal.Body className='app-modal-content'>
        <div className='app-modal-title'>{title}</div>
        <div className='app-modal-form'>
          {children}
        </div>
      </Modal.Body>
    </Modal>
  )
}